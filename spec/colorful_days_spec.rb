require 'spec_helper'

describe ColorfulDays do
  it "String#color_256" do
    expect("text".color_256(1)).to eq("\e[38;5;1mtext\e[0m")
    expect("text".color_256(208)).to eq("\e[38;5;208mtext\e[0m")
  end

  it "String#ansi" do
    expect("text".ansi(1)).to eq("\e[38;5;1mtext\e[0m")
    expect("text".ansi(5)).to eq("\e[38;5;5mtext\e[0m")
    expect("text".ansi(:black)).to eq("\e[38;5;0mtext\e[0m")
    expect("text".ansi(:red)).to eq("\e[38;5;1mtext\e[0m")
    expect("text".ansi(:light_green)).to eq("\e[38;5;10mtext\e[0m")
  end

  it "String#gray" do
    expect("text".gray(1)).to eq("\e[38;5;233mtext\e[0m")
    expect("text".gray(5)).to eq("\e[38;5;237mtext\e[0m")
    expect("text".gray(23)).to eq("\e[38;5;255mtext\e[0m")
  end

  it "String#rgb" do
    expect("text".rgb(5, 2, 0)).to eq("\e[38;5;208mtext\e[0m")
  end

  it "String#similar_color" do
    expect("text".similar_color("#e33830")).to eq("\e[38;5;160mtext\e[0m")
    expect("text".similar_color("#0075c2")).to eq("\e[38;5;32mtext\e[0m")
    expect("text".similar_color("#d3e5e5")).to eq("\e[38;5;188mtext\e[0m")
    expect("text".similar_color("#f3983b")).to eq("\e[38;5;172mtext\e[0m")
    expect("text".similar_color("#01ac5e")).to eq("\e[38;5;35mtext\e[0m")
    expect("text".similar_color("#7e479a")).to eq("\e[38;5;97mtext\e[0m")
    expect("text".similar_color("#f39fc1")).to eq("\e[38;5;218mtext\e[0m")
    expect("text".similar_color("#515659")).to eq("\e[38;5;59mtext\e[0m")
    expect("text".similar_color("#ffe43f")).to eq("\e[38;5;220mtext\e[0m")
    expect("text".similar_color("#a9d053")).to eq("\e[38;5;149mtext\e[0m")
    expect("text".similar_color("#00aeb9")).to eq("\e[38;5;37mtext\e[0m")
    expect("text".similar_color("#a61c69")).to eq("\e[38;5;125mtext\e[0m")
  end
end

