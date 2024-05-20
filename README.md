# The Great Bash One-Liner

```bash
detach() { nohup "$@" >/dev/null 2>&1 & disown ; } ; c() { cd "$@" && clear && ls -lah ; } ; alias c.='c ..' ; alias l='ls -lah' ; alias e='vim' ; alias s='systemctl' ; alias d='docker' ; alias dc='docker compose' ; alias tf='terraform'
```
