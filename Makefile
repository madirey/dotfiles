USAGE := "Usage: make project=<project-name> <project-type>"

check-env:
ifndef project
	$(error $(USAGE))
else
	@echo Executing...
endif

django_req ?= 'django'

project_root ?= $(PWD)/$(project)

python ?= /usr/local/bin/python2.7

allocate: check-env
	@echo Creating project directory...
	@mkdir -p $(project)

venv: check-env
	@echo Creating virtual environment...
	@bash -c ". /usr/local/bin/virtualenvwrapper.sh && mkvirtualenv --no-site-packages -a $(project_root) --python=$(python) $(project)"

django: check-env allocate venv
	@echo Installing Django...
	@bash -c ". /usr/local/bin/virtualenvwrapper.sh && workon $(project) && pip install $(django_req)"
	@echo Done.
	@echo
	@echo Now just type "workon $(project)" to begin.
