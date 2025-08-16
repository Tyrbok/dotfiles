#!/usr/bin/env python3

import os
import fnmatch
import argparse
import statistics

def find_largest_files(directory, pattern, n):
    # List to store all matching files with their sizes
    files_with_sizes = []

    # Walk through the directory and all subdirectories
    for root, _, files in os.walk(directory):
        for file in files:
            # Check if the file matches the pattern (or match all if no pattern)
            if not pattern or fnmatch.fnmatch(file, pattern):
                # Build the full file path
                full_path = os.path.join(root, file)
                # Get the file size
                size = os.path.getsize(full_path)
                # Add to the list
                files_with_sizes.append((full_path, size))

    # Sort files by size in descending order
    files_with_sizes.sort(key=lambda x: x[1], reverse=True)

    # Return the full list and the top n files
    return files_with_sizes, files_with_sizes[:n]

def main():
    # Set up argument parser
    parser = argparse.ArgumentParser(description="Find the largest files in a directory tree.")
    parser.add_argument("directory", type=str, help="The directory to search in.")
    parser.add_argument("--pattern", type=str, default=None, help="Optional file pattern to match (e.g., '*.json'). If omitted, all files are considered.")
    parser.add_argument("--n", type=int, default=1, help="Number of largest files to display (default: 1).")

    # Parse arguments
    args = parser.parse_args()
    directory = args.directory
    pattern = args.pattern
    n = args.n

    # Ensure the directory exists
    if not os.path.isdir(directory):
        print(f"The directory '{directory}' does not exist or is not accessible.")
        exit(1)

    # Find the largest files matching the pattern
    all_files, largest_files = find_largest_files(directory, pattern, n)

    if largest_files:
        print(f"The {n} largest file(s){' matching the pattern ' + pattern if pattern else ''}:")
        for file, size in largest_files:
            if size >= 1024 * 1024:
                size_display = f"{size / (1024 * 1024):.2f} MB"
            else:
                size_display = f"{size / 1024:.2f} KB"
            print(f"{file} ({size_display})")

        # Calculate statistics for all files
        total_files = len(all_files)
        sizes = [size for _, size in all_files]
        average_size = sum(sizes) / total_files if total_files > 0 else 0
        median_size = statistics.median(sizes) if total_files > 0 else 0
        percentile_95 = statistics.quantiles(sizes, n=100)[94] if total_files > 0 else 0
        percentile_99 = statistics.quantiles(sizes, n=100)[98] if total_files > 0 else 0

        print(f"\nTotal files analyzed: {total_files}")
        print(f"Average file size: {average_size / 1024:.2f} KB")
        print(f"Median file size: {median_size / 1024:.2f} KB")
        print(f"95th percentile file size: {percentile_95 / 1024:.2f} KB")
        print(f"99th percentile file size: {percentile_99 / 1024:.2f} KB")
    else:
        print(f"No files{' matching the pattern ' + pattern if pattern else ''} were found in the directory.")

if __name__ == "__main__":
    main()