import json

def form_bulk_edit_to_json_from_file(file_path):
    try:
        with open(file_path, "r") as file:
            data_string = file.read()
        data_dict = {}
        # convert to json
        for line in data_string.split('\n'):
            key, value = line.split(':')
            data_dict[key] = value

        # Convert the dictionary to a JSON object
        json_data = json.dumps(data_dict, indent=4)
    except FileNotFoundError:
        print(f"File not found: {file_path}")
    except json.JSONDecodeError:
        print(f"Invalid JSON format in the file: {file_path}")
    
    return json_data

def main():
    input_file = input("Enter the path to the parameter keys input file: ")
    output_file = input("Enter the path to the request output file: ")

    data = form_bulk_edit_to_json_from_file(input_file)
    
    print(f"Json data:  {data}")

    with open(output_file, 'w') as file:
        file.write("=================Json Data=============\n")
        file.write(str(data)+"\n")

    print(f"Generated JSON Request saved to {output_file}")

if __name__ == "__main__":
    main()