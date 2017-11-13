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

b0 = init_board()
b1 = copy(b0)
b1[1,2] = -1
b2= copy(b1)
b2[1,4] = -1

# b0 -> b00, b01
# b1 -> b11
# b2 -> b20, b21
