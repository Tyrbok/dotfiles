#!/usr/bin/env python3.7

import iterm2
# This script was created with the "basic" environment which does not support adding dependencies
# with pip.

async def main(connection):
    # Your code goes here. Here's a bit of example code that adds a tab to the current window:
    app = await iterm2.async_get_app(connection)
    window = app.current_terminal_window
    # tab = await window.async_create_tab()
    #tab = window.
    if window is not None:
        session = window.current_tab.current_session
        splited = await session.async_split_pane(vertical=True)
        await splited.async_activate()
        
        await session.async_send_text('cd /Volumes/Seagate\ Bac/backups/My_Passport_20171225/backup_iomega/cdteb/__pending\n')
        await session.async_send_text('../bin/phd.py add -i\n')

        await splited.async_send_text('cd /Volumes/Seagate\ Bac/backups/My_Passport_20171225/backup_iomega/cdteb/__pending\n')
        await splited.async_send_text('open ./\n')
        await splited.async_send_text('../bin/phd.py run\n')


    else:
        # You can view this message in the script console.
        print("No current window")

iterm2.run_until_complete(main)
