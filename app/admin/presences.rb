ActiveAdmin.register Presence do
  permit_params :status, :date_presence, :student_id, :school_class_id, :user_id

  form do |f|
    f.inputs "Presence Details" do
      f.input :status
      f.input :student_id, as: :select, collection: (current_user.teacher?) ? current_user.students.all.map {|s| [s.name, s.id]} : Student.all.map {|st| [st.name, st.id]}
      f.input :school_class_id, as: :select, collection: (current_user.teacher?) ? SchoolClass.where(user_id: current_user.id) : SchoolClass.all
      f.input :date_presence
      f.hidden_field :user_id, value: current_user.id
    end
    f.actions
  end

end
