function symm!(robot, side)
    if isborder(robot, side)
        while !isborder(robot, inverse(side))
            move!(robot, inverse(side))
        end
    else
        move!(robot, side)
        symm!(robot, side)
        move!(robot, side)
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side) +2) %4)
