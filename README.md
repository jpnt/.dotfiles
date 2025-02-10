# jpnt dotfiles

## How to use:

```sh
cd $HOME && git clone https://github.com/jpnt/.dotfiles && cd .dotfiles

stow [dir]
```

---

## service-turnstile-runit

This folder contains user-specific services using turnstile w/ runit backend

### Resources

Please refer to docs: https://docs.voidlinux.org/config/services/user-services.html#turnstile

Other resources + what motivated me:
  - https://smarden.org/runit/faq#userservices
  - https://forum.artixlinux.org/index.php/topic,3268.0.html
  - https://forum.artixlinux.org/index.php/topic,3067
  - https://codeberg.org/dwl/dwl/#running-dwl
  - https://smarden.org/runit/runsv.8
  - https://smarden.org/runit/sv.8
  - https://man.voidlinux.org/pause

### Why?

By not having a server, the wayland compositor-only architecture
pushes the responsability of session configuration away from
startup scripts like xinitrc with startx/xinit/sx.

That means that all programs that run with the compositor
must run **after** it.

Some more minimal compositors like dwl make it ideal to have
a per user process setup, achieving a more fine-grained, robust
system where each service is managed independently by a service
manager, in this case runit/runsv.

I use turnstile with the runit backend, made in mind for
Void Linux because that is what I currently use, allowing 
me to use **one** service manager, `sv`, to control
both system level and user level services. However the 
same idea can be applied for `s6`, `anopa`, (just) `runit`,
`dinit`, or `systemd --user`.

I still run some (one-shot) child processes of dwl instead 
of having services to not overcomplicate things, such as
setting the resolution, refresh-rate and wallpaper. Check 
the `dwlchild` script for an example.

### User Services

- dbus-user
- pipewire
- gammastep
- syncthing
- foot-server
