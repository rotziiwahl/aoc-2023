with open("input") as F:
    lines = F.readlines()

def record_to_dict(record):
    ret = dict()
    measurements = [m.strip() for m in record.split(',')]
    print(measurements)
    for m in measurements:
        (value, key) = m.split(' ')
        ret[key] = int(value)
    return ret

def get_power(records):
    bag = dict()
    for k in ["red", "green", "blue"]:
        bag[k] = max([r.get(k, 0) for r in records])
    return bag['red']*bag['green']*bag['blue']

    

sum = 0
for line in lines:
    line = line.strip()
    game_part, line = line.split(':')
    game_num = int(game_part.split(" ")[-1])
    records = [r.strip() for r in line.split(';')]
    record_dicts = [record_to_dict(r) for r in records]
    power = get_power(record_dicts)
    sum += power

print(sum)
