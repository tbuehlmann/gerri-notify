module GeriNotify
  require 'dbus'
  require 'pry'
class DBusConnector < DBus::Object
  # Create an interface
  dbus_interface "org.freedesktop.Notifications" do
    # Create a hello method in the interface:
    dbus_method :GetCapabilities, "out ret:as" do
      puts "GetCapabilities"
      ["body"]
    end

    dbus_method :Notify, "in app_name:s, in replaces_id:u, in app_icon:s, in summary:s, in body:s, in actions:a, in hints:d, in expire_time:i, out notification_id:i" do |app_name,replaces_id,app_icon,summary,body,actions,hints,expire_time|
      puts "#{app_name}: #{summary} -- #{body}"
      1
    end

    dbus_method :CloseNotification, "in id:u" do |id|
      puts "Should be closing #{id}, if i knew how to do it"
    end

    dbus_method :GetServerInformation, "out name:s, out vendor:s, out version:s" do
      puts "GetServerInformation"
      ["geri-notify", "knopwob", GeriNotify::VERSION.to_s]
    end

    dbus_signal :NotificationClosed, "id:u, reason:u"

    dbus_signal :ActionInvoked, "id:u, action_key:s"

  end
end
end
