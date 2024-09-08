console: ## Open rails console.
	RAILS_LOG_LEVEL="debug" bin/rails console

sandbox: ## Open rails console in sandbox.
	RAILS_LOG_LEVEL="debug" bin/rails console --sandbox

server: ## Starts the server.
	RAILS_LOG_LEVEL="debug" bin/rails server -p 3001


migrate: 
	bin/rails db:migrate

outdated: ## Shows outdated packages.
	bundle outdated

routes:
	bin/rails routes

test:
	bin/rspec

rollback:
	bin/rails db:rollback

rebase:
	git branch | rg '\bmain\b|\bmaster\b' | xargs -n 1 git rebase -i

ssh:
	doctl compute ssh nazgul-1

prod_console:
	kamal app exec -i 'bin/rails console'
