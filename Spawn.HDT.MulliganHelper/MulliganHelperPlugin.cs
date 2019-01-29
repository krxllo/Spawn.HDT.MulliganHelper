using Hearthstone_Deck_Tracker.Plugins;
using System;
using System.Windows.Controls;

namespace Spawn.HDT.MulliganHelper
{
    public class MulliganHelperPlugin : IPlugin
    {
        public string Name => "Mulligan Helper";

        public string Description => "Provied information during mulligan.";

        public string ButtonText => null;

        public string Author => "CLJunge";

        public Version Version => new Version(System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString(3));

        public MenuItem MenuItem => null;

        public void OnButtonPress()
        {
        }

        public void OnLoad()
        {
        }

        public void OnUnload()
        {
        }

        public void OnUpdate()
        {
        }
    }
}