function find_passage(r::Robot)
    num_steps=0; 
    side=Ost
    while isborder(r,Nord)==true 
        num_steps+=1
        moves!(r,side,num_steps)
        side=inverse(side)
    end
end

moves!(r,side,num_steps)=
    for _ in 1:num_steps move!(r,side) 
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))
