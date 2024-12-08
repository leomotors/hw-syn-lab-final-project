import os


def remove_trailing_whitespace(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    with open(file_path, 'w') as file:
        for line in lines:
            file.write(line.rstrip() + '\n')


def scan_and_process_files(directory):
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.v'):
                file_path = os.path.join(root, file)
                remove_trailing_whitespace(file_path)


if __name__ == "__main__":
    directory = 'final-real.srcs'
    scan_and_process_files(directory)
