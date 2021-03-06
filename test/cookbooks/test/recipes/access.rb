postgresql_server_install 'postgresql' do
  version '9.6'
  password '12345'
  port 5432
  setup_repo true
  action [:install, :create]
end

postgresql_access 'postgresql host superuser' do
  access_type 'host'
  access_db 'all'
  access_user 'postgres'
  access_addr '127.0.0.1/32'
  access_method 'md5'
  notifies :reload, 'service[postgresql]'
end

postgresql_user 'sous_chef test user' do
  user 'sous_chef'
  superuser true
  password '67890'
end

postgresql_access 'a sous_chef local superuser' do
  access_type 'host'
  access_db 'all'
  access_user 'sous_chef'
  access_method 'md5'
  access_addr '127.0.0.1/32'
  notifies :reload, 'service[postgresql]'
end

service 'postgresql' do
  extend PostgresqlCookbook::Helpers
  service_name lazy { platform_service_name }
  supports restart: true, status: true, reload: true
  action :nothing
end
