def fred block
    l = lambda { return }
    l.call
    puts "back1"
    block.call
    puts "backa"
    p1 = Proc.new {return}
    p1.call
    puts "back2"
end
fred(lambda{return})