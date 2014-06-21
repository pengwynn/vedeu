Given(/^the interface "(.*?)" is defined$/) do |interface|
  Vedeu::InterfaceRepository.create({ name: interface, entity: Vedeu::DummyInterface, options: {} })
end

Given(/^the command "(.*?)" is defined$/) do |command|
  Vedeu::CommandRepository.create({ name: command, entity: Vedeu::DummyCommand, options: { keyword: command } })
end

When(/^the input "(.*?)" is entered$/) do |input|
  pending
end
