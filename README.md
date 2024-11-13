# ESX-IT_job

    Overview:
    This script adds an IT job role to your FiveM server, providing players with an interactive
    experience as software installers. The job includes vehicle management, mission-based
    deliveries, and a mini-game for added challenge, designed for players with the 'itjob' role
    in ESX.

    Features:
    1. IT Job Role Integration:
       - Accessible only to players with the 'itjob' role.
       - Dedicated blips and interaction points specific to IT job players.

    2. Service Vehicle Management:
       - Allows players to spawn a dedicated service vehicle to transport software packages.
       - Vehicles must be loaded with packages before starting deliveries.
       - Option to return the vehicle to the garage when finished.

    3. Mission-Based Software Delivery:
       - Randomized delivery points provide fresh destinations each mission.
       - Players install software at each delivery location, receiving rewards upon completion.

    4. Interactive Mini-Game for Software Installation:
       - A mini-game challenges players during software installation at delivery points.
       - Uses the `bl_ui` module by Byte Labs Studio to create an engaging skill-check.
       - Successful completion rewards the player, while failure prompts a retry option.

    Dependencies:
    - **bl_ui** by Byte Labs Studio:
      * This script uses `bl_ui` for the mini-game component. Make sure to install it to
        enable the mini-game.
      * Repository: https://github.com/Byte-Labs-Studio/bl_ui

    Instructions:
    1. Place this script in your FiveM server's resources folder.
    2. Install `bl_ui` from Byte Labs Studio by following the setup instructions on their GitHub page.
    3. Ensure the ESX framework is installed and configured.
    4. Add 'itjob' as a defined job in your ESX job list.
    5. Customize job locations and vehicle options in the Config settings if desired.

    Configuration:
    - This script includes customizable options for:
      * Job-specific vehicle settings
      * Delivery locations and mission blips
      * Mini-game difficulty and duration
      * Notifications and UI prompts
