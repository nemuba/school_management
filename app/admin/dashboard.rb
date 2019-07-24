ActiveAdmin.register_page "Dashboard" do
  menu priority: 0, label: proc {I18n.t("active_admin.dashboard")}

  breadcrumb do
    ['admin', I18n.t("active_admin.dashboard")]
  end

  content title: proc {I18n.t('active_admin.dashboard')} do
    columns do
      column do
        if current_user.teacher?
          panel I18n.t('messages.recents', model: Activity.model_name.human(count: 2).titleize) do
            table_for current_user.activities.all.limit(10).each, i18n: Activity do |activity|
              column :fields_of_expertise do |activity|
                activity.fields_of_expertise.upcase
              end
              column :description do |activity|
                link_to activity.description.truncate(30).html_safe, admin_activity_path(activity)
              end
              activity.column :date_activity do |activity|
                I18n.l activity.date_activity
              end
            end # table_for
          end # panel recent activities
        end
      end # column activity
      column do
        if current_user.teacher?
          panel I18n.t('messages.recents', model: Observation.model_name.human(count: 2).titleize) do
            table_for current_user.observations.all.limit(10).each, i18n: Observation do |observation|
              column :description do |observation|
                link_to observation.description.truncate(30).html_safe, admin_observation_path(observation)
              end
              column :school_class do |observation|
                link_to observation.school_class.to_s, admin_school_class_path(observation.school_class)
              end
              column :date_observation do |observation|
                I18n.l observation.date_observation
              end
            end # table_for
          end # panel recent activities
        end
      end # column observations
    end # columns

    if current_user.admin?
      div class: "blank_slate_container", id: "dashboard_default_message" do
        span class: "blank_slate" do
          span "Bem vindo ao painél administrativo do Sistema Escolar !"
          small "Trazendo facilidades ao seu trabalho."
        end
      end
    end
  end # content


end
