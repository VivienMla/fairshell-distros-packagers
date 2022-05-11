cont_name=fairshell-fedora-builder

all:
	sudo docker rmi $(cont_name) | true
	sudo docker build --no-cache -t $(cont_name) .

doc:
	pandoc -s -N --toc -o Notes.pdf Notes.md
