node[:deploy].each do |app_name, deploy|

  template "#{deploy[:deploy_to]}/current/application/config/database.php" do
    source "database.php.erb"
    mode 0660
    group deploy[:group]

    variables({
      :db_host =>     (deploy[:database][:db_host] rescue nil),
      :db_username =>     (deploy[:db_username][:database] rescue nil),
      :db_password => (deploy[:db_password][:database] rescue nil),
      :db_name =>       (deploy[:db_name][:database] rescue nil)
    })

   only_if do
     File.directory?("#{deploy[:deploy_to]}/current/application/config/")
   end
  end
end