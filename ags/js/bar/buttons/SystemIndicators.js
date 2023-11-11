import HoverRevealer from '../../misc/HoverRevealer.js';
import PanelButton from '../PanelButton.js';
import Asusctl from '../../services/asusctl.js';
import Indicator from '../../services/onScreenIndicator.js';
import icons from '../../icons.js';
import options from '../../options.js';
import FontIcon from '../../misc/FontIcon.js';
import { App, Widget } from '../../imports.js';
import { Bluetooth, Audio, Notifications, Network, Battery } from '../../imports.js';

const ProfileIndicator = () => Widget.Icon({
    connections: [[Asusctl, icon => {
        icon.visible = Asusctl.profile !== 'Balanced';
        icon.icon = icons.asusctl.profile[Asusctl.profile];
    }]],
});

const ModeIndicator = () => Widget.Icon({
    connections: [[Asusctl, icon => {
        icon.visible = Asusctl.mode !== 'Hybrid';
        icon.icon = icons.asusctl.mode[Asusctl.mode];
    }]],
});

const MicrophoneMuteIndicator = () => Widget.Icon({
    icon: icons.audio.mic.muted,
    connections: [[Audio, icon => {
        icon.visible = Audio.microphone?.isMuted;
    }, 'microphone-changed']],
});

const DNDIndicator = () => Widget.Icon({
    icon: icons.notifications.silent,
    binds: [['visible', Notifications, 'dnd']],
});

const BluetoothDevicesIndicator = () => Widget.Box({
    connections: [[Bluetooth, box => {
        box.children = Bluetooth.connectedDevices
            .map(({ iconName, name }) => HoverRevealer({
                indicator: Widget.Icon(iconName + '-symbolic'),
                child: Widget.Label(name),
            }));

        box.visible = Bluetooth.connectedDevices.length > 0;
    }, 'notify::connected-devices']],
});

const BluetoothIndicator = () => Widget.Icon({
    className: 'bluetooth',
    icon: icons.bluetooth.enabled,
    binds: [['visible', Bluetooth, 'enabled']],
});

const NetworkIndicator = () => Widget.Stack({
    items: [
        ['wifi', Widget.Icon({
            connections: [[Network, icon => {
                icon.icon = Network.wifi?.iconName;
            }]],
        })],
        ['wired', Widget.Icon({
            connections: [[Network, icon => {
                icon.icon = Network.wired?.iconName;
            }]],
        })],
    ],
    binds: [['shown', Network, 'primary']],
});

const AudioIndicator = () => Widget.Icon({
    connections: [[Audio, icon => {
        if (!Audio.speaker)
            return;

        const { muted, low, medium, high, overamplified } = icons.audio.volume;
        if (Audio.speaker.isMuted)
            return icon.icon = muted;

        icon.icon = [[101, overamplified], [67, high], [34, medium], [1, low], [0, muted]]
            .find(([threshold]) => threshold <= Audio.speaker.volume * 100)[1];
    }, 'speaker-changed']],
});

const BatteryIndicator = Widget.Box({
    className: 'battery-bar',
    children: [
        Widget.Stack({
            items: [
                ['true', Widget.Icon({ binds: [['icon', Battery, 'icon-name']] })],
                ['false', Widget.Icon({ binds: [['icon', Battery, 'icon-name']] })],
                //['false', Widget.Icon({ binds: [['icon', Battery, 'icon-name']] })],
                //['true', FontIcon({ icon: icons.battery.charging })],
            ],
            connections: [[Battery, stack => {
                stack.shown = `${Battery.charging || Battery.charged}`;
            }],
            [Battery, w => {
                w.toggleClassName('charging', Battery.charging || Battery.charged);
                w.toggleClassName('medium', Battery.percent < options.battaryBar.medium);
                w.toggleClassName('low', Battery.percent < options.battaryBar.low);
            }]
            ],
        }),
        Widget.Label({
            binds: [['label', Battery, 'percent', p => `${p}%`]],
        }),
    ]
});

export default () => PanelButton({
    className: 'quicksettings panel-button',
    onClicked: () => App.toggleWindow('quicksettings'),
    onScrollUp: () => {
        Audio.speaker.volume += 0.02;
        Indicator.speaker();
    },
    onScrollDown: () => {
        Audio.speaker.volume -= 0.02;
        Indicator.speaker();
    },
    connections: [[App, (btn, win, visible) => {
        btn.toggleClassName('active', win === 'quicksettings' && visible);
    }]],
    child: Widget.Box({
        children: [
            Asusctl?.available && ProfileIndicator(),
            Asusctl?.available && ModeIndicator(),
            MicrophoneMuteIndicator(),
            DNDIndicator(),
            BluetoothDevicesIndicator(),
            BluetoothIndicator(),
            NetworkIndicator(),
            AudioIndicator(),
            BatteryIndicator
        ],
    }),
});
