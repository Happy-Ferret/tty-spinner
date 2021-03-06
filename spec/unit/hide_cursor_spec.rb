# coding: utf-8

RSpec.describe TTY::Spinner, ':hide_cursor' do
  let(:output) { StringIO.new('', 'w+') }

  it "hides cursor" do
    spinner = TTY::Spinner.new(output: output, hide_cursor: true)
    4.times { spinner.spin }
    spinner.stop
    output.rewind
    expect(output.read).to eq([
      "\e[?25l\e[1G|",
      "\e[1G/",
      "\e[1G-",
      "\e[1G\\",
      "\e[?25h\e[1G\\\n"
    ].join)
  end

  it "restores cursor on success" do
    spinner = TTY::Spinner.new(output: output, hide_cursor: true)
    4.times { spinner.spin }
    spinner.success('success')
    output.rewind
    expect(output.read).to eq([
      "\e[?25l\e[1G|",
      "\e[1G/",
      "\e[1G-",
      "\e[1G\\",
      "\e[?25h\e[1G\u2714 success\n"
    ].join)
  end

  it "restores cursor on error" do
    spinner = TTY::Spinner.new(output: output, hide_cursor: true)
    4.times { spinner.spin }
    spinner.error('error')
    output.rewind
    expect(output.read).to eq([
      "\e[?25l\e[1G|",
      "\e[1G/",
      "\e[1G-",
      "\e[1G\\",
      "\e[?25h\e[1G\u2716 error\n"
    ].join)
  end
end
