function init_board()
    zeros(Int8, 2, 5)
end

function is_symmetrical(b)
    for i = 1:2
        for j = 1:2
            if b[i,j] != b[i,6-j]
                return false
            end
        end
    end
    true
end

function build_board(ps)
    b = init_board()
    for p in ps
        (y, x) = p
        if x == 0
            continue
        else
            b[x, y] = 4
        end
    end
    b
end

function put_pawn()
    ps = [ (y, x) for x = 0:2 for y = 1:5 ]
    zs = [ [p1, p2, p3, p4, p5] for p1 in ps for p2 in ps for p3 in ps for p4 in ps for p5 in ps if p1[1] < p2[1] < p3[1] < p4[1] < p5[1] ]
    map(x -> build_board(x), zs)
end

function no_block(ss)
    s0 = []
    s1 = []
    for s in ss
        if is_symmetrical(s)
            push!(s0, s)
        else
            push!(s1, s)
        end
    end
    (s0, s1)
end

function one_block(ss)
    s1 = filter(b -> b[1,2] == 0, ss)
    ([], s1)
end

function two_blocks(ss)
    zz = filter(b -> b[1,2] == 0 && b[1,4] == 0, ss)
    s0 = []
    s1 = []
    for s in zz
        if is_symmetrical(s)
            push!(s0, s)
        else
            push!(s1, s)
        end
    end
    (s0, s1)
end

ss = put_pawn()
s0 = no_block(ss)
s1 = one_block(ss)
s2 = two_blocks(ss)

println(s0)
println(s1)
println(s2)
