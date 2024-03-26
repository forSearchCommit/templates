import json
import urllib.parse
import hashlib

def Generate_request(dict, secret_key, sort, upper):

    if sort == "y" or sort == "Y" : 
        sorted_keys = sorted(dict.keys())
    else :
        sorted_keys = dict.keys()

    url_encoded_parts = []
    for key in sorted_keys:
        value = dict[key]
        if key == "notifyUrl" and (value.startswith("http://") or value.startswith("https://")):
            url_encoded_parts.append(f"{key}={value}")
        else:
            url_encoded_parts.append(f"{key}={urllib.parse.quote(str(value))}")
        # url_encoded_parts.append(f"{value}")
        
    url_encoded = "&".join(url_encoded_parts)
    # url_encoded = "".join(url_encoded_parts)
    final = "&key=".join([url_encoded, secret_key])
    # final = "".join([secret_key, url_encoded])

    if upper == "y" or upper == "Y" : 
        md5_hash = hashlib.md5(final.encode()).hexdigest().upper()
    else :
        md5_hash = hashlib.md5(final.encode()).hexdigest().lower()
    
    dict["sign"] = md5_hash
    # dict["key"] = md5_hash
    # dict["terminal"] = "1"
    
    final_request = json.dumps(dict, sort_keys=True)
    # final_request = json.dumps(dict, sort_keys=False)
    return final_request, final, md5_hash

def read_keys_from_file(file_path):
    try:
        with open(file_path, "r") as json_file:
            data = json.load(json_file)
    except FileNotFoundError:
        print(f"File not found: {file_path}")
    except json.JSONDecodeError:
        print(f"Invalid JSON format in the file: {file_path}")
    return data

def main():
    input_file = input("Enter the path to the parameter keys input file: ")
    output_file = input("Enter the path to the request output file: ")
    secret_key = input("Enter the path secret keys: ")
    sort = input("Enter sort dictionary (y/Y): ")
    upper = input("Enter signing case upper (y/Y): ")

    dict = read_keys_from_file(input_file)
    json_request, query_string, signature = Generate_request(dict, secret_key, sort, upper)
    
    print(f"Input File:  {dict}")
    print(f"Json Request Body:  {json_request}")
    print(f"Query String:  {query_string}")
    print(f"Signed:  {signature}")

    with open(output_file, 'w') as file:
        file.write("=================Input File=============\n")
        file.write(str(dict)+"\n")
        file.write("==============Json Request Body=========\n")
        file.write(json_request+"\n")
        file.write("================Query String============\n")
        file.write(query_string+"\n")
        file.write("===================Signed===============\n")
        file.write(signature+"\n")

    print(f"Generated JSON Request saved to {output_file}")

if __name__ == "__main__":
    main()