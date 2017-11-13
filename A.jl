function b(x, y)
    binomial(x, y)
end

c1 = 1 + b(7,1) + b(7,2)
c2 = 1 + b(5,1) + b(5,2)
c3 = 9
c = c1*c2*c3

# println(c) 4176
# println(c*c) 17438976

function init_board()
    zeros(Int8, 3, 5)
end

function is_symmetrical(b)
    for i = 1:3
        for j = 1:2
            if b[i,j] != b[i,6-j]
                return false
            end
        end
    end
    true
end

function put_king()
    a1 = []
    a2 = []
    for i = 1:3
        for j = 2:4
            b = init_board()
            b[i,j] = 1
            if is_symmetrical(b)
                push!(a1,b)
            else
                push!(a2,b)
            end
        end
    end
    (a1, a2)
end

function put_advisor(r)
    (a1, a2) = r
    ps = [(1,2),(1,4),(2,3),(3,2),(3,4)]
    (a3, a4) = put_one_advisor(r, ps)
    (a5, a6) = put_two_advisors(r, ps)
    b1 = map(x -> (x, 1), a1)
    b2 = map(x -> (x, 1), a2)
    b3 = map(x -> (x, 2), a3)
    b4 = map(x -> (x, 2), a4)
    b5 = map(x -> (x, 3), a5)
    b6 = map(x -> (x, 3), a6)
    append!(b1, b3)
    append!(b1, b5)
    append!(b2, b4)
    append!(b2, b6)
    (b1, b2)
end

function put_one_advisor(r, ps)
    (a1, a2) = r
    b1 = []
    b2 = []
    for a in a1
        for p in ps
            b = copy(a)
            (x, y) = p
            if b[x,y] != 0
                continue
            else
                b[x,y] = 2
                if is_symmetrical(b)
                    push!(b1, b)
                else
                    push!(b2, b)
                end
            end
        end
    end
    for a in a2
        for p in ps
            b = copy(a)
            (x, y) = p
            if b[x,y] != 0
                continue
            else
                b[x,y] = 2
                push!(b2, b)
            end
        end
    end
    (b1, b2)
end

function put_two_advisors(r, ps)
    (a1, a2) = r
    b1 = []
    b2 = []
    pps = [(x, y) for x in ps for y in ps if x < y]
    for a in a1
        for pp in pps
            b = copy(a)
            (p1, p2) = pp
            (x1, y1) = p1
            (x2, y2) = p2
            if b[x1,y1] != 0 || b[x2,y2] != 0
                continue
            else
                b[x1,y1] = 2
                b[x2,y2] = 2
                if is_symmetrical(b)
                    push!(b1, b)
                else
                    push!(b2, b)
                end
            end
        end
    end
    for a in a2
        for pp in pps
            b = copy(a)
            (p1, p2) = pp
            (x1, y1) = p1
            (x2, y2) = p2
            if b[x1,y1] != 0 || b[x2,y2] != 0
                continue
            else
                b[x1,y1] = 2
                b[x2,y2] = 2
                push!(b2, b)
            end
        end
    end
    (b1, b2)
end

function put_elephant(r)
    (b1, b2) = r
    ps = [(1,1),(1,3),(1,5),(2,1),(2,5),(3,1),(3,5)]
    (b3, b4) = put_one_elephant(r, ps)
    (b5, b6) = put_two_elephants(r, ps)
    append!(b1, b3)
    append!(b1, b5)
    append!(b2, b4)
    append!(b2, b6)
    (b1, b2)
end

function put_one_elephant(r, ps)
    (a1, a2) = r
    b1 = []
    b2 = []
    for aa in a1
        (a, c) = aa
        for p in ps
            b = copy(a)
            (x, y) = p
            if b[x,y] != 0
                continue
            else
                b[x,y] = 3
                if is_symmetrical(b)
                    push!(b1, (b, c+1))
                else
                    push!(b2, (b, c+1))
                end
            end
        end
    end
    for aa in a2
        (a, c) = aa
        for p in ps
            b = copy(a)
            (x, y) = p
            if b[x,y] != 0
                continue
            else
                b[x,y] = 3
                push!(b2, (b, c+1))
            end
        end
    end
    (b1, b2)
end

function put_two_elephants(r, ps)
    (a1, a2) = r
    b1 = []
    b2 = []
    pps = [(x, y) for x in ps for y in ps if x < y]
    for aa in a1
        (a, c) = aa
        for pp in pps
            b = copy(a)
            (p1, p2) = pp
            (x1, y1) = p1
            (x2, y2) = p2
            if b[x1,y1] != 0 || b[x2,y2] != 0
                continue
            else
                b[x1,y1] = 3
                b[x2,y2] = 3
                if is_symmetrical(b)
                    push!(b1, (b, c+2))
                else
                    push!(b2, (b, c+2))
                end
            end
        end
    end
    for aa in a2
        (a, c) = aa
        for pp in pps
            b = copy(a)
            (p1, p2) = pp
            (x1, y1) = p1
            (x2, y2) = p2
            if b[x1,y1] != 0 || b[x2,y2] != 0
                continue
            else
                b[x1,y1] = 3
                b[x2,y2] = 3
                push!(b2, (b, c+2))
            end
        end
    end
    (b1, b2)
end

d1 = put_king()
d2 = put_advisor(d1)

# (b1, b2) = d2
# println(length(b1)) 11
# println(length(b2)) 108

d3 = put_elephant(d2)

# (b1, b2) = d3
# println(length(b1)) 51
# println(length(b2)) 2*1644

x = 51
y = 1644
total = x + b(x,2) + x*y + y + b(y,1) + b(y,2)
# println(total) 1439004
