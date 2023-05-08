return function(L_1_arg1)
	assert(L_1_arg1, "Number missing or invalid")
	local L_2_ = {
		N = 10 ^ 30,
		O = 10 ^ 27,
		Sp = 10 ^ 24,
		Sx = 10 ^ 21,
		Qn = 10 ^ 18,
		Qd = 10 ^ 15,
		T = 10 ^ 12,
		B = 10 ^ 9,
		M = 10 ^ 6,
		K = 10 ^ 3
	}
	local L_3_ = L_1_arg1
	local L_4_ = 0
	for L_5_forvar1, L_6_forvar2 in next, L_2_ do
		if L_1_arg1 >= L_6_forvar2 and L_6_forvar2 > L_4_ then
			L_3_ = tostring(math.floor(L_1_arg1 / L_6_forvar2))..L_5_forvar1.."+"
			L_4_ = L_6_forvar2
		end
	end
	return L_3_
end