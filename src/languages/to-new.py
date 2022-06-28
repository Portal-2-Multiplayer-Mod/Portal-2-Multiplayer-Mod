import ast

source = ast.literal_eval(open("en-US.json", "r").read())

n_dict = {}

with open("fr-FR.json", "r") as host:
    host = ast.literal_eval(host.read())
    with open("fr.json", "w") as write:
        for x in range(len(host.keys())):
            n_dict[list(source.values())[x]] = list(host.values())[x]
        write.write(str(n_dict))

print(n_dict)
