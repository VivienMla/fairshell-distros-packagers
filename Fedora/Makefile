cont_name=fairshell-fedora-builder

all:
	sudo docker rmi $(cont_name) | true
	sudo docker build --build-arg http_proxy=$(http_proxy) --build-arg https_proxy=$(https_proxy) --no-cache -t $(cont_name) .

doc:
	pandoc -s -N --toc -o Notes.pdf Notes.md
