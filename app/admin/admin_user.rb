ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, role_ids: []

  index do
    selectable_column
    id_column
    column :email 
    column (:role) { |user| user.roles.map(&:name).join } if current_admin_user.has_role? :super_admin 
    column :created_at
    actions
  end

  controller do 
    def update 
      if params[:admin_user][:password].blank? && (current_admin_user.has_role? :super_admin) 
        params[:admin_user].delete("password") 
        params[:admin_user].delete("password_confirmation")
      end
      super 
    end 
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :roles, as: :select, collection: Role.all, input_html: { class: 'prettyselect'} if current_admin_user.has_role? :super_admin 
    end
    f.actions
  end
end
