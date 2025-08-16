#!/usr/bin/env python3

import os
import argparse
import fnmatch
import yaml
import subprocess
import sys

# Constante para la ruta del archivo de configuración
CONFIG_PATH = os.path.expanduser('~/.c2p.config.yaml')

def create_default_config(config_path):
    default_config = {
        'exclude': ['.DS_Store', '.git', '*.swp', '*.tmp'],
        'default_output': 'file',
        'default_template': None,
        'templates': {
            'fastapi': "Here is a part of the code for an API built with FastAPI.\n\nPlease respond OK if you understand it.\n\n----\n\n<code>"
        }
    }
    with open(config_path, 'w') as config_file:
        yaml.dump(default_config, config_file, sort_keys=False)
    with open(config_path, 'a') as config_file:
        config_file.write(
            "\ndefault_output: file # Possible values: 'file', 'cb', 'std'\n"
            "default_template: null\n"
        )

def read_config_file(config_path):
    config = {}
    if not os.path.exists(config_path):
        create_default_config(config_path)
    with open(config_path, 'r') as config_file:
        config = yaml.safe_load(config_file)
    return config

def should_exclude(file_path, exclude_patterns):
    for pattern in exclude_patterns:
        if fnmatch.fnmatch(file_path, pattern) or fnmatch.fnmatch(os.path.basename(file_path), pattern):
            return True
    return False

def get_file_names(paths, exclude_patterns):
    file_names = []
    ignored_files = []
    for path in paths:
        if os.path.isfile(path):
            if not should_exclude(path, exclude_patterns) and os.path.getsize(path) > 0:
                file_names.append(path)
            else:
                ignored_files.append(path)
        elif os.path.isdir(path):
            for root, _, files in os.walk(path):
                if should_exclude(root, exclude_patterns):
                    ignored_files.append(root)
                    continue
                for file in files:
                    full_path = os.path.join(root, file)
                    if not should_exclude(full_path, exclude_patterns) and os.path.getsize(full_path) > 0:
                        file_names.append(full_path)
                    else:
                        ignored_files.append(full_path)
    return file_names, ignored_files

def read_file_content(file):
    try:
        with open(file, 'r', encoding='utf-8') as f:
            return f.read()
    except UnicodeDecodeError:
        try:
            with open(file, 'r', encoding='latin-1') as f:
                return f.read()
        except UnicodeDecodeError:
            return "Error: Unable to decode file content."

def format_file_content(file_names, template=None):
    formatted_content = ""
    for file in file_names:
        content = read_file_content(file)
        formatted_content += f"## {os.path.basename(file)}\n\n```\n{content}\n```\n\n"
    if template:
        formatted_content = template.replace("<code>", formatted_content)
    return formatted_content

def copy_to_clipboard(content):
    platform = sys.platform
    if platform == 'darwin':
        subprocess.run('pbcopy', input=content.encode('utf-8'), check=True)
    elif platform == 'win32':
        subprocess.run('clip', input=content.encode('utf-8'), check=True)
    else:
        subprocess.run('xclip', input=content.encode('utf-8'), check=True)

def parse_arguments():
    parser = argparse.ArgumentParser(description="List file names from given paths and save their content to output.txt.")
    parser.add_argument('paths', nargs='+', help="Paths to files or directories")
    parser.add_argument('--exclude', nargs='*', default=[], help="Patterns to exclude from file names")
    parser.add_argument('--output-file', type=str, help="Name of the output file")
    parser.add_argument('--output-cb', action='store_true', help="Copy the output to clipboard")
    parser.add_argument('--output-std', action='store_true', help="Print the output to standard output")
    parser.add_argument('--quiet', action='store_true', help="Suppress output messages")
    parser.add_argument('--template', type=str, help="Template to use for formatting the output")
    return parser.parse_args()

def handle_output(args, formatted_content, ignored_files, file_names):
    config = read_config_file(CONFIG_PATH)
    default_output = config.get('default_output', 'file')

    if not args.output_cb and not args.output_std and not args.output_file:
        if default_output == 'cb':
            args.output_cb = True
        elif default_output == 'std':
            args.output_std = True
        else:
            args.output_file = 'output.txt'

    output_message = ""
    if args.output_cb:
        copy_to_clipboard(formatted_content)
        output_message = "📋 The content has been copied to the clipboard."
    elif args.output_std:
        print(formatted_content)
        output_message = "📄 The content has been printed to standard output."
    else:
        output_file_name = args.output_file if args.output_file else 'output.txt'
        with open(output_file_name, 'w') as output_file:
            output_file.write(formatted_content)
        output_message = f"✅ Generated file name: {output_file_name}"

    if not args.quiet:
        print(f"📁 Ignored files ({len(ignored_files)}):")
        for file in ignored_files:
            print(f"  - {file}")

        print(f"\n📂 Included files ({len(file_names)}):")
        for file in file_names:
            print(f"  - {file}")

        print(f"\n{output_message} 🎉")

def main():
    args = parse_arguments()
    config = read_config_file(CONFIG_PATH)
    default_exclude_patterns = config.get('exclude', [])
    default_template = config.get('default_template', None)
    templates = config.get('templates', {})

    exclude_patterns = default_exclude_patterns + args.exclude
    file_names, ignored_files = get_file_names(args.paths, exclude_patterns)
    template_name = args.template if args.template else default_template
    if template_name and template_name not in templates:
        available_templates = ", ".join(templates.keys())
        print(f"❌ Error: Template '{template_name}' not found. Available templates: {available_templates}")
        sys.exit(1)
    template = templates.get(template_name, None)
    formatted_content = format_file_content(file_names, template)

    handle_output(args, formatted_content, ignored_files, file_names)

if __name__ == "__main__":
    main()
