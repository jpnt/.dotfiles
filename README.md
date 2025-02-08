# jpnt dotfiles

## How to use:

```sh

cd $HOME && git clone https://github.com/jpnt/.dotfiles && cd .dotfiles

stow *

```

---

## service-turnstile-runit

This folder contains user-specific services using turnstile w/ runit backend

### Resources

Please refer to docs: https://docs.voidlinux.org/config/services/user-services.html#turnstile
Other resources/ what motivated me:
  - https://forum.artixlinux.org/index.php/topic,3268.0.html
  - https://forum.artixlinux.org/index.php/topic,3067
  - https://codeberg.org/dwl/dwl/#running-dwl
  - https://smarden.org/runit/runsv.8
  - https://man.voidlinux.org/pause

### Why?

By not having a server, the wayland compositor-only architecture
pushes the responsability of session configuration away from
startup scripts like xinitrc with startx/xinit (it sucked anyway).

That means that all programs that run with the compositor
must run **after** it.

Some more minimal compositors like dwl make it ideal to have
a per user process setup, achieving a more fine-grained, robust
system where each service is managed independently by a service
manager, in this case runit/runsv.

I use turnstile with the runit backend, made in mind for
Void Linux and dwl because that is what I currently use.
The same idea for `s6`, `anopa`, (just) `runit`, `dinit`,
or `systemd --user` could be applied.

Because of the tight management of environment variables by turnstile
and the lack of dependency management in runit I still run some processes as child 
processes of dwl instead of having services to not overcomplicate things.
Check the `dwlchild` script for an example.

### Services

- dbus
- pipewire
- gammastep
- syncthing
