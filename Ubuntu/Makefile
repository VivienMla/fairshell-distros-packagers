cont_name=fairshell-ubuntu-builder

all:
	sudo docker rmi $(cont_name) | true
	sudo docker build --no-cache -t $(cont_name) .
