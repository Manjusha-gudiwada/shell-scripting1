help: ## show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | grep -v fgrep

catalogue: ## install catalogue.
	@bash components/catalogue.sh
	
mongodb: ## install mongodb.
	@bash components/mongodb.sh
	
redis: ## install redis.
	@bash components/redis.sh
	
user: ## install user.
	@bash components/user.sh
	
cart: ## install cart.
	@bash components/cart.sh
	
mysql: ## install mysql.
	@bash components/mysql.sh
	
rabbitmq: ## install rabbitmq.
	@bash components/rabbitmq.sh
	
payment: ## install payment.
	@bash components/payment.sh
	
frontend: ## install frontend.
	@bash components/frontend.sh