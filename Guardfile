guard :minitest, all_after_pass: true, focus_on_failed: true, env: { 'no_simplecov' => true } do
  watch(%r{^test/(.*)_test\.rb})
  watch(%r{^lib/(.+)\.rb}) do |m|
    "test/lib/#{m[1]}_test.rb"
  end
  watch(%r{^test/test_helper\.rb})       { 'test' }
end

guard :bundler do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end
