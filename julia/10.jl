function mark_square!(r::Robot, n::Int)
    c1 = 1
    c2 = 1
    while c1 <= n && !isborder(r, Ost)
        while c2 < n && !isborder(r, Nord)
            putmarker!(r)
            move!(r, Nord)
            c2 += 1
        end
        putmarker!(r)
        moves!(r, Sud, c2 - 1)
        c2 = 1
        move!(r, Ost)
        c1 += 1
    end
    if isborder(r, Ost) && c1 <= n
        while c2 < n && !isborder(r, Nord)
            putmarker!(r)
            move!(r, Nord)
            c2 += 1
        end
        putmarker!(r)
        moves!(r, Sud, c2 - 1)
    end
    moves!(r, West, c1 - 1)
end


function moves_if_possible_numeric!(r::Robot, side::HorizonSide, num_steps::Int)::Int
    while num_steps > 0 && move_if_possible!(r, side)
        num_steps -= 1
    end
    return num_steps
end


function mark_chess!(r::Robot, n::Int)  
    steps = get_left_down_angle!(r)
    side = Nord
    to_mark = true
    steps_to_ost_border = move_until_border!(r, Ost)
    move_until_border!(r, West)
    last_side = steps_to_ost_border % 2 == 1 ? Sud : Nord
    last_n_steps = 0
    while !isborder(r, Ost)
        while !isborder(r, side)
            if to_mark
                mark_square!(r, n)
            end

            last_n_steps = moves_if_possible_numeric!(r, side, n)
            if last_n_steps == 0 && !isborder(r, side)
                to_mark = !to_mark
            end
        end
        if to_mark
            mark_square!(r, n)
        end
        to_mark = !to_mark
        moves_if_possible!(r, Ost, n)
        moves!(r,inverse_side(side), n - last_n_steps)
        side = inverse_side(side)
    end
end
