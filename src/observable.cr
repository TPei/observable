module Observable
  @observers = [] of Observer
  @changed = false

  def changed?
    @changed
  end

  def changed(state = true)
    @changed = state
  end

  def add_observer(observer : Observer)
    @observers << observer
  end

  def count_observers
    @observers.size
  end

  def delete_observer(observer : Observer)
    @observers.delete(observer)
  end

  def delete_observers
    @observers = [] of Observer
  end

  def notify_observers
    return unless @changed

    @observers.each do |observer|
      observer.update(self)
    end

    @changed = false
  end

  def notify_observers!
    @observers.each do |observer|
      observer.update(self)
    end
  end

  @[Deprecated("Use `#notify_observers!` instead")]
  def alert_observers
    notify_observers!
  end
end
