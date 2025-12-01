def main():
    data = []
    with open("input.txt") as file:
        data = file.readlines()
    
    data = [line.replace("L", "-").replace("R", "") for line in data][:-1]
    data = [int(line) for line in data]
    
    curr = 50
    zeros = 0
    tmp_zer = 0
    
    for line in data:
        tmp_zer += do_spin(curr, line)
        new = (curr + line) % 100

        zeros += abs(line)// 100
        if curr != 0:
            if line > 0 and curr > new:
                zeros += 1
            if line < 0 and (curr < new or new == 0):
                zeros += 1
        assert zeros == tmp_zer, (curr, new, line, zeros, tmp_zer)

        curr = new % 100
        assert curr < 100 and curr >= 0

    print(zeros, tmp_zer)


def do_spin(curr, distance):
    res = 0
    if distance > 0:
        for _ in range(distance):
            curr += 1
            curr %= 100
            if curr == 0:
                res += 1
    else:
        for _ in range(abs(distance)):
            curr -= 1
            curr %= 100
            if curr == 0:
                res += 1
    return res

main()
