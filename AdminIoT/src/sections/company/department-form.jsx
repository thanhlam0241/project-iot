/* eslint-disable  */

import { useState } from 'react';
import PropsType from 'prop-types';

// import Paper from '@mui/material/Paper';
import {
    Paper,
    Grid,
    Stack,
    Checkbox,
    Button,
    Backdrop,
    TextField,
    IconButton,
    Typography,
    FormControlLabel
}
    from '@mui/material';
import CloseIcon from '@mui/icons-material/Close';

export default function Form({ open, handleClose, action, setup }) {
    console.log(setup)
    const [code, setCode] = useState(setup.type === 'UPDATE' ? setup.data.code : '');
    const [managementUnitName, setManagementUnitName] = useState(setup.type === 'UPDATE' ? setup.data.name : '');

    const handleSubmit = () => {
        if (!code || !managementUnitName) return;
        const data = {
            id: setup.data ? setup.data.id : '',
            code,
            name: managementUnitName
        };
        action(setup.type === 'ADD' ? 'add' : 'update', data);
    }

    const options = {
        type: setup.type === 'ADD' ? 'add' : 'update',
        label: setup.type === 'ADD' ? 'Thêm mới đơn vị/phòng ban' : 'Chi tiết',
        labelButton: setup.type === 'ADD' ? 'Thêm' : 'Cập nhật',
    }

    return (
        <Backdrop
            sx={{ color: '#fff', zIndex: (theme) => theme.zIndex.drawer + 1 }}
            open={open}
        // onClick={handleClose}
        >
            <Paper sx={{ width: '50%', overflow: 'auto', padding: 2 }}>
                <Stack direction="row" alignItems="center" justifyContent="space-between" mb={1}>
                    <Typography variant="h4" gutterBottom>
                        {options.label}
                    </Typography>
                    <IconButton onClick={handleClose} >
                        <CloseIcon />
                    </IconButton>
                </Stack>
                <Grid container spacing={3}>
                    <Grid item xs={12} sm={12}>
                        <TextField
                            required
                            id="code"
                            value={code}
                            name="code"
                            label="Mã đơn vị/phòng ban"
                            fullWidth
                            variant="standard"
                            onChange={(e) => setCode(e.target.value)}
                        />
                    </Grid>
                    <Grid item xs={12} sm={12}>
                        <TextField
                            required
                            id="managementUnitName"
                            name="managementUnitName"
                            label="Tên đơn vị/phòng ban"
                            value={managementUnitName}
                            fullWidth
                            variant="standard"
                            onChange={(e) => setManagementUnitName(e.target.value)}
                        />
                    </Grid>
                    <Grid item xs={12}>
                        <Button onClick={handleSubmit} variant='contained' fullWidth sx={{ fontSize: 20, margin: '0 auto', display: 'block' }}>
                            {options.labelButton}
                        </Button>
                    </Grid>
                </Grid>
            </Paper>
        </Backdrop>
    );
}

Form.propTypes = {
    open: PropsType.bool,
    handleClose: PropsType.func,
};