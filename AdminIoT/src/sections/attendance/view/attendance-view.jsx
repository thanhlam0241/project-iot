import * as React from 'react';
import PropTypes from 'prop-types';

import Tab from '@mui/material/Tab';
import Box from '@mui/material/Box';
import Tabs from '@mui/material/Tabs';
// import Typography from '@mui/material/Typography';

import MachineView from '../machine'
import TimesheetView from '../timesheet'
import AttendanceListView from '../attendance-list'

function TabPanel(props) {
    const { children, value, index, ...other } = props;

    return (
        <div
            role="tabpanel"
            style={{ flexGrow: 1 }}
            hidden={value !== index}
            id={`vertical-tabpanel-${index}`}
            aria-labelledby={`vertical-tab-${index}`}
            {...other}
        >
            {value === index && (
                <Box sx={{ p: 3 }}>
                    {children}
                </Box>
            )}
        </div>
    );
}

TabPanel.propTypes = {
    children: PropTypes.node,
    index: PropTypes.number.isRequired,
    value: PropTypes.number.isRequired,
};

function a11yProps(index) {
    return {
        id: `vertical-tab-${index}`,
        'aria-controls': `vertical-tabpanel-${index}`,
    };
}

export default function AttendanceView() {
    const [value, setValue] = React.useState(0);

    const handleChange = (event, newValue) => {
        setValue(newValue);
    };

    return (
        <Box
            sx={{ flexGrow: 1, bgcolor: 'background.paper' }}
        >
            <Tabs
                orientation="horizontal"
                variant="scrollable"
                value={value}
                onChange={handleChange}
                aria-label="Vertical tabs example"
                sx={{ borderRight: 1, borderColor: 'divider' }}
            >
                <Tab label="Máy chấm công" {...a11yProps(0)} />
                <Tab label="Bảng công" {...a11yProps(1)} />
                <Tab label="Bản ghi chấm công" {...a11yProps(2)} />
            </Tabs>
            <TabPanel value={value} index={0}>
                <MachineView />
            </TabPanel>
            <TabPanel value={value} index={1}>
                <AttendanceListView />
            </TabPanel>
            <TabPanel value={value} index={2}>
                <TimesheetView />
            </TabPanel>

        </Box>
    );
}
