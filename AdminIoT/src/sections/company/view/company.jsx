/* eslint-disable */

import * as React from 'react';
import PropTypes from 'prop-types';

import {
    Tab, Box, Tabs, Typography,
}
    from '@mui/material';

import Socket from '../socket'
import Manager from '../manager';
import Employee from '../employee';
import Department from '../department';
import { CompanyInformation } from '../overview';

function TabPanel(props) {
    const { children, value, index, ...other } = props;

    return (
        <div
            role="tabpanel"
            hidden={value !== index}
            id={`vertical-tabpanel-${index}`}
            aria-labelledby={`vertical-tab-${index}`}
            {...other}
            style={{ flexGrow: 1 }}
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

export default function VerticalTabs() {
    const [value, setValue] = React.useState(0);

    const handleChange = (event, newValue) => {
        setValue(newValue);
    };

    return (
        <Box
            sx={{ flexGrow: 1, bgcolor: '#fff' }}
        >
            <Tabs
                // orientation="vertical"
                // variant="scrollable"
                value={value}
                onChange={handleChange}
                aria-label="Vertical tabs example"
                sx={{ borderRight: 1, borderColor: 'divider' }}
            >
                <Tab label="Thông tin chung" {...a11yProps(0)} />
                <Tab label="Đơn vị/phòng ban" {...a11yProps(1)} />
                <Tab label="Nhân viên" {...a11yProps(2)} />
                <Tab label="Quản lý" {...a11yProps(3)} />
                <Tab label="Socket" {...a11yProps(4)} />
            </Tabs>
            <TabPanel value={value} index={0}>
                <CompanyInformation />
            </TabPanel>
            <TabPanel value={value} index={1}>
                <Department />
            </TabPanel>
            <TabPanel value={value} index={2}>
                <Employee />
            </TabPanel>
            <TabPanel value={value} index={3}>
                <Manager />
            </TabPanel>
            <TabPanel value={value} index={4}>
                <Socket />
            </TabPanel>
        </Box>
    );
}
