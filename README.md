# observable [![Build Status](https://travis-ci.org/TPei/observable.svg?branch=master)](https://travis-ci.org/TPei/observable)
Simple implementation of the Observer pattern in Crystal. It is loosely based on the [Observable](http://ruby-doc.org/stdlib-2.0.0/libdoc/observer/rdoc/Observable.html) module from Ruby :)

## Installation

Add to your shard.yml

```yaml
dependencies:
  observable:
    github: tpei/observable
    branch: master
```

and then install the library into your project with

```bash
$ crystal deps
```

## Usage

Include observable in the class you want to observe:

```crystal
require "observable/observable"

class ToObserve
  include Observable
end
```
This provides you with the following methods:
- `add_observer(observer : Observer)`
- `changed(state=true)`
- `changed?`
- `count_observers`
- `delete_observer(observer : Observer)`
- `delete_observers`
- `notify_observers`

and as an added bonus, because I dislike the forced `changed` call precondition:
- `alert_observers`, which notifies no matter if changed or not


Then you can include observer in the class you want observing:

```crystal
require "observable/observer"

class Observing
  include Observer

  def update(observable : Observable)
    # do whatever you want to do if your observable changes
  end
end
```
This only gives you an `update(observable : Observable)` method you should override, because it willl raise an error otherwise.

Unfortunately we don't have ruby's verbosity and dynamism here so it's all a little more static. Especially the `update` method can really only pass on the `observable` object.
