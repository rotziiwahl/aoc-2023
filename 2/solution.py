bag = {'red': 12, 'green': 13, 'blue': 14}

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

def is_possible(record):
    return all([record[k] <= bag[k] for k in record.keys()])

sum = 0
for line in lines:
    line = line.strip()
    game_part, line = line.split(':')
    game_num = int(game_part.split(" ")[-1])
    records = [r.strip() for r in line.split(';')]
    print(records)
    record_dicts = [record_to_dict(r) for r in records]
    print(record_dicts)
    if all(is_possible(r) for r in record_dicts):
        sum += game_num

print(sum)
