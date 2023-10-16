function diagonal!(r)
    for side in (West, Sud, Ost, Nord)
        n = num_markers!(r, side)
        along!(r, inverse(side), n)
    end
    putmarker!(r)
end

function num_markers!(r, side)
    num_steps=0
    while !isborder(r,side) && !isborder(r, next(side))
        move!(r,side)
        move!(r,next(side))
        num_steps += 1
        putmarker!(r)
    end
    return num_steps
end

function along!(r, side, num_steps)
    for _i in 1:num_steps
        move!(r,side)
        move!(r,next(side))
    end
end

invserse(side::HorizonSide) = HorizonSide((Int(side)+2)% 4)
next(side::HorizonSide) = HorizonSide((Int(side)+1)% 4)