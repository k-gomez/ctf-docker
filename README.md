# Dockerfile for CTF challenges

## What is included?

Different tools for different types of challenges. It mainly includes tools for reverse-engineering (e.g., radare2), forensics (e.g., exiftool), and pwn (e.g., pwntools).

## Usage

Build the container on your host system. `ctf:ubuntu22.04` is the name of the container:
```
sudo docker build -t ctf:ubuntu22.04 .
```

Run the container in detached mode (`-d`), remove the container when done (`-rm`), mounting current working directory (`-v`), and removing some security features (`-cap-add` and `--security-opt`):
```
sudo docker run -d --rm -v $PWD:/pwd --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -i ctf:ubuntu22.04 
```

Get the container-id:
```
sudo docker ps
```

Execute an interactive `/bin/zsh` shell on the container:
```
sudo docker exec -it <container-id> /bin/zsh 
```

To exit the container, run `exit` in the terminal.

Stop the container:
```
sudo docker stop <container-id>
```

# Credits

LiveOverflow for the initial dockerfile: [his docker YouTube video](https://www.youtube.com/watch?v=cPGZMt4cJ0I&pp=ygUKY3RmIGRvY2tlcg%3D%3D)
