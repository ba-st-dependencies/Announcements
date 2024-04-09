# Announcements

A fork of the `Announcements` framework to be used as a dependency in [ba-st](https://github.com/ba-st)
for GS/64.

The `upstream` branch is supposed to track the changes in
the main branch of [GemTalk/Announcements](https://github.com/GemTalk/Announcements).

The `release-candidate` is the branch where our changes land before releasing a version.

[![GS64 - Unit Tests](https://github.com/ba-st-dependencies/Announcements/actions/workflows/unit-tests-gs64.yml/badge.svg)](https://github.com/ba-st-dependencies/Announcements/actions/workflows/unit-tests-gs64.yml)
[![GS64 Components](https://github.com/ba-st-dependencies/Announcements/actions/workflows/loading-gs64-components.yml/badge.svg)](https://github.com/ba-st-dependencies/Announcements/actions/workflows/loading-gs64-components.yml)
[![Markdown Lint](https://github.com/ba-st-dependencies/Announcements/actions/workflows/markdown-lint.yml/badge.svg)](https://github.com/ba-st-dependencies/Announcements/actions/workflows/markdown-lint.yml)

[![GS64 3.7.0](https://img.shields.io/badge/GS64-3.7.0-informational)](https://gemtalksystems.com/products/gs64/)
[![GS64 3.7.1](https://img.shields.io/badge/GS64-3.7.1-informational)](https://gemtalksystems.com/products/gs64/)

The announcement framework is an event notification framework. Compared to "traditional"
event systems in this new framework, an event is a real object rather than a symbol.
An event someone might want to announce, such as a button click or an attribute
change, is defined as a subclass of the abstract superclass `Announcement`.

The subclass can have instance variables for additional information to pass along,
such as a timestamp, or mouse coordinates at the time of the event, or the old
value of the parameter that has changed.

To signal the actual occurrence of an event, the "announcer" creates and configures
an instance of an appropriate announcement, then broadcasts that instance.
Objects subscribed to receive such broadcasts from the announcer receive a broadcast
notification together with the instance. They can talk to the instance to find
out any additional information about the event that has occurred!

## License

- The code is licensed under [MIT](LICENSE).
- The documentation is licensed under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).
