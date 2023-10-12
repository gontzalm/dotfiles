from config_variables._helpers import GroupsGenerator
from config_variables.conf import Config

groups_generator = GroupsGenerator(Config.GROUP_LIST)
groups = groups_generator.generate_groups()
group_keys = groups_generator.generate_keybindings()
