Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	scope "(:locale)", :locale => /en|de/ do
		root  'pages#index'
		get   'favicon',    to: 'pages#favicon'
		match 'container_definition', to: 'pages#container_definition', via: 'get'
		match 'init_create',          to: 'inits#create',               via: 'post', as: 'init_create_submit'
		match 'usage_create',         to: 'usages#create',              via: 'post', as: 'usage_create_submit'
		match 'usage_match',          to: 'usages#match',               via: 'post', as: 'usage_match_submit'
		match 'data_validate',        to: 'data_formats#validate',      via: 'post', as: 'data_validate_submit'
		match 'usage_policy',         to: 'pages#usage_policy',         via: 'get'
		match 'data_format',          to: 'pages#data_format',          via: 'get'
		match 'provenance',           to: 'pages#provenance',           via: 'get'
	end
end
