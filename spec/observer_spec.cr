require "spec"
require "../src/observable.cr"
require "../src/observer.cr"

class ToObserve
  include Observable
end

class Observing
  include Observer

  @notified = false

  def update(observable : Observable)
    @notified = true
  end

  def notified?
    @notified
  end
end

describe "Observable" do
  describe "#changed?" do
    it "it returns the current changed status (true / false)" do
      to = ToObserve.new
      to.changed?.should eq false
      to.changed
      to.changed?.should eq true
    end
  end

  describe "#changed?" do
    it "it returns the current changed status (true / false)" do
      to = ToObserve.new
      to.changed?.should eq false
      to.changed
      to.changed?.should eq true
    end
  end

  describe "#add_observer" do
    it "adds and observer to the observers array" do
      to = ToObserve.new
      obs = Observing.new
      
      to.count_observers.should eq 0
      to.add_observer obs
      to.count_observers.should eq 1
    end
  end
  
  describe "#count_observers" do
    it "returns the number of listed observers" do
      to = ToObserve.new
      obs = Observing.new
      
      to.count_observers.should eq 0
      to.add_observer obs
      to.count_observers.should eq 1
    end
  end

  describe "#delete_observer" do
    it "deletes the given observer from the list" do
      to = ToObserve.new
      obs = Observing.new

      to.count_observers.should eq 0
      to.add_observer obs
      to.count_observers.should eq 1
      to.delete_observer(obs)
      to.count_observers.should eq 0
    end

    it "does not do anything if the given object isn't even registered" do
      to = ToObserve.new
      obs = Observing.new

      to.count_observers.should eq 0
      to.delete_observer(obs)
      to.count_observers.should eq 0
    end
  end

  describe "#delete_observers" do
    it "clears the observers list" do
      to = ToObserve.new
      obs = Observing.new
      obs2 = Observing.new

      to.count_observers.should eq 0
      to.add_observer obs
      to.add_observer obs2
      to.count_observers.should eq 2
      to.delete_observers
      to.count_observers.should eq 0
    end
  end

  describe "#notify_observers" do
    context "changed is set" do
      it "calls notify on all observing objects" do
        to = ToObserve.new
        obs = Observing.new
        obs2 = Observing.new

        to.count_observers.should eq 0
        to.add_observer obs
        to.add_observer obs2
        to.count_observers.should eq 2
        to.changed
        to.notify_observers
        
        obs.notified?.should eq true
        obs2.notified?.should eq true
      end
    end

    context "changed is not set" do
      it "does not do anything" do
        to = ToObserve.new
        obs = Observing.new
        obs2 = Observing.new

        to.count_observers.should eq 0
        to.add_observer obs
        to.add_observer obs2
        to.count_observers.should eq 2
        to.notify_observers
        
        obs.notified?.should eq false
        obs2.notified?.should eq false
      end
    end
  end
  
  describe "#alert_observers" do
    context "changed is set" do
      it "calls notify on all observing objects" do
        to = ToObserve.new
        obs = Observing.new
        obs2 = Observing.new

        to.count_observers.should eq 0
        to.add_observer obs
        to.add_observer obs2
        to.count_observers.should eq 2
        to.changed
        to.notify_observers
        
        obs.notified?.should eq true
        obs2.notified?.should eq true
      end
    end

    context "changed is not set" do
      it "calls notify on all observing objects" do
        to = ToObserve.new
        obs = Observing.new
        obs2 = Observing.new

        to.count_observers.should eq 0
        to.add_observer obs
        to.add_observer obs2
        to.count_observers.should eq 2
        to.changed
        to.notify_observers
        
        obs.notified?.should eq true
        obs2.notified?.should eq true
      end
    end
  end
end
