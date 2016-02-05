node[:deploy].each do |app_name, deploy|

  template "#{deploy[:deploy_to]}/current/application/config/database.php" do
    source "database.php.erb"
    mode 0660
    group deploy[:group]

    variables(
      :db_host =>     (deploy[:db_host] rescue nil),
      :db_username =>     (deploy[:db_username] rescue nil),
      :db_password => (deploy[:db_password] rescue nil),
      :db_name =>       (deploy[:db_name] rescue nil)
    )

   only_if do
     File.directory?("#{deploy[:deploy_to]}/current/application/config/")
   end
  end
end