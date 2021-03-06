# @title The Vedeu DSL
# The Vedeu DSL

Coupled with the API (for interacting with the running client application), the
 DSL provides the mechanism to configure aspects of your application whilst
 using Vedeu.

## Interfaces

An Interface is a basic element in the GUI. It usually but does not necessarily
correspond to a region of the terminal screen (for example, an Interface might
not be displayed at certain points in an application life cycle).

Much of the behavior of an Interface comes from child objects that are defined
under the Interface. These objects are described in more detail in their
respective sections below.

Here is an example of declarations for an `interface` block:

```ruby
interface 'main' do
  visible true # whether to show the interface
  focus! # focus this interface
  cursor true # Show the cursor when this section is focused
  colour foreground: '#ffffff', # set interface foreground
         background: '#000033'  # and background colors
  group 'general' # set interface group

  geometry do
    # size and position details
  end
  border do
    # border properties
  end
  keymap do
    # keymap that is in effect when this interface is focused
  end
  views do
    # details about how to render the interface
  end
end
```

### Declaring interface sub-objects

Every object in the DSL besides interface itself is defined for a particular
interface. This can either be declared implicitly by defining the object inside
an `interface` block or explicitly, by passing the interface name as a first
argument to the declaration.

That is, these are equivalent ways to declare a Geometry for an existing
interface

```ruby
interface 'main' do
  geometry do
    # some geometry
  end

  # some other declarations
end
```

or you can say

```ruby
interface 'main' do
  # some other declarations
end

geometry 'main' do
  # some geometry
end
```

## Borders

{include:Vedeu::Borders::DSL}

### Setting a title for the border

{include:Vedeu::Borders::DSL#title}

### Customising the appearance of the border

{include:Vedeu::Borders::DSL#bottom_left}
{include:Vedeu::Borders::DSL#bottom_right}
{include:Vedeu::Borders::DSL#horizontal}
{include:Vedeu::Borders::DSL#top_left}
{include:Vedeu::Borders::DSL#top_right}
{include:Vedeu::Borders::DSL#vertical}

### Enabling/disabling the border

{include:Vedeu::Borders::DSL#enable!}
{include:Vedeu::Borders::DSL#disable!}

### Enabling/disabling an aspect of the border

{include:Vedeu::Borders::DSL#bottom}
{include:Vedeu::Borders::DSL#left}
{include:Vedeu::Borders::DSL#right}
{include:Vedeu::Borders::DSL#top}

## Geometry

{include:Vedeu::Geometry::DSL}

### Setting the interface dimensions

{include:Vedeu::Geometry::DSL#centred}
{include:Vedeu::Geometry::DSL#height}
{include:Vedeu::Geometry::DSL#width}
{include:Vedeu::Geometry::DSL#columns}
{include:Vedeu::Geometry::DSL#rows}
{include:Vedeu::Geometry::DSL#x}
{include:Vedeu::Geometry::DSL#xn}
{include:Vedeu::Geometry::DSL#y}
{include:Vedeu::Geometry::DSL#yn}

## Groups

{include:Vedeu::DSL::Group}

### Add interfaces to groups

{include:Vedeu::DSL::Group.group}

## Keymaps

{include:Vedeu::DSL::Keymap}
{include:Vedeu::DSL::Keymap.keymap}
{include:Vedeu::DSL::Keymap#name}

## Menus

{include:Vedeu::Menus::DSL}
{include:Vedeu::Menus::DSL#item}
{include:Vedeu::Menus::DSL#items}
{include:Vedeu::Menus::DSL#name}

## Views

{include:Vedeu::DSL::View}
{include:Vedeu::DSL::Interface.interface}

### Immediate rendering

{include:Vedeu::DSL::View.renders}

### Deferred rendering

{include:Vedeu::DSL::View.views}

### Specifying view content

{include:Vedeu::DSL::Line}
{include:Vedeu::DSL::Line#line}
{include:Vedeu::DSL::Line#streams}

`@todo` More documentation coming soon.

#### Authors Notes

The Rubydoc documentation has more specific information about the DSL methods
 demonstrated above: [RubyDoc](http://rubydoc.info/gems/vedeu).

I've tried to write the DSL in a way which makes it read nice; believing that
 this will make it easier to use. I hope this is the case for you.
