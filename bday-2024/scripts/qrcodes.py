import os
import sys
import getopt
import subprocess

elements = 'fuoco acqua terra aria'.split(' ')

def create_qr_codes(strings, output_dir):
    # Ensure the output directory exists
    os.makedirs(output_dir, exist_ok=True)

    for string in strings:
        # Create a safe filename from the string
        safe_filename = "".join(c if c.isalnum() or c in ('-', '.') else '_' for c in string).strip()
        filename = f"{safe_filename}.png"
        filepath = os.path.join(output_dir, filename)

        # Call the qrencode command to create the QR code
        try:
            subprocess.run(["qrencode", "-o", filepath, string], check=True)
            print(f"QR code for '{string}' saved to {filepath}")
        except subprocess.CalledProcessError as e:
            print(f"Error creating QR code for '{string}': {e}")


def main(argv):
    output_dir = ""

    try:
        opts, _ = getopt.getopt(argv, "hd:", ["help", "directory="])
    except getopt.GetoptError:
        print("Usage: script.py -d <output_directory>")
        sys.exit(2)

    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print("Usage: script.py -d <output_directory>")
            sys.exit()
        elif opt in ("-d", "--directory"):
            output_dir = arg

    if not output_dir:
        print("Output directory is required. Use -d to specify it.")
        sys.exit(2)

    # List of strings for which to generate QR codes
    strings = []

    elements = 'fuoco acqua terra aria'.split(' ')
    personaggi = []

    for e in elements:
        strings.append('fonte-%s' % (e))
    poppable = elements[:]
    while (poppable):
        head = poppable.pop(0)
        for e in poppable:
            strings.append('combo-%s-%s' % (head, e))
            personaggi.append('%s-%s' % (head, e))
            print("""    .icon.chi-%s-%s::after {
        content: "Fuoco";
    }""" % (head, e))

    for p in personaggi:
        for e in elements:
            strings.append('dai_%s_%s' % (e, p))

    oggetti = ["lance", "maze", "cages", "bridge"]
    templates = []
    templates.append("""
.tag-hai-{oggetto} .se-hai.hai-{oggetto} {{
    display: initial;
}}
.tag-hai-{oggetto} .non-hai.hai-{oggetto} {{
    display: none;
}}
.setting-dai-{oggetto} .dai-cosa.dai-{oggetto} {{
    display: initial;
}}""")
    templates.append("""        <div class="se-hai hai-fuoco">
            <h1 class="icon icon-{oggetto} clickable" data-close="true" data-story="mostra-{oggetto}"></h1>
        </div>""")
    templates.append("""        {{"id": "mostra-{oggetto}", "url": "~/mostra-{oggetto}.html", "template": "~/story-template.html", "data": {{"oggetto": "{oggetto}"}}}},""")
    for template in templates:
        for e in (elements + oggetti):
            print(template.format(oggetto = e))

    # Create QR codes
    create_qr_codes(['chi-%s' % p for p in personaggi], output_dir)
    scambi = []
    for o in (elements + oggetti):
        scambi = scambi + ['dai_%s_%s' % (o, p) for p in personaggi]
    create_qr_codes(scambi, output_dir)

if __name__ == "__main__":
    main(sys.argv[1:])
