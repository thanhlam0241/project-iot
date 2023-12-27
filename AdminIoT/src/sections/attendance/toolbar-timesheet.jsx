/* eslint-disable */

import PropTypes from 'prop-types';

import Stack from '@mui/material/Stack';
import Tooltip from '@mui/material/Tooltip';
import Toolbar from '@mui/material/Toolbar';
import IconButton from '@mui/material/IconButton';
import OutlinedInput from '@mui/material/OutlinedInput';
import InputAdornment from '@mui/material/InputAdornment';

import Iconify from 'src/components/iconify';
import BasicSelect from 'src/components/select/select-basic';;
import { DatePicker } from '@mui/x-date-pickers/DatePicker';

// ----------------------------------------------------------------------

export default function TableToolbar({
    filterName,
    onFilterName,
    onOpenFilter,
    date = new Date(),
    onChaneDate
}) {

    const handleChangeDate = (value) => {
        onChaneDate(value)
    }
    const handleFilterName = (event) => {
        onFilterName(event.target.value);
    }

    return (
        <Toolbar
            sx={{
                height: 66,
                display: 'flex',
                justifyContent: 'space-between',
                p: (theme) => theme.spacing(0, 1, 0, 3),
                mb: '5px'
            }}
        >
            <Stack direction="row" alignItems="center" justifyContent="flex-start" gap={2} >
                <OutlinedInput
                    value={filterName}
                    onChange={handleFilterName}
                    placeholder="Tìm kiếm theo tên"
                    startAdornment={
                        <InputAdornment position="start">
                            <Iconify
                                icon="eva:search-fill"
                                sx={{ color: 'text.disabled', width: 20, height: 20 }}
                            />
                        </InputAdornment>
                    }
                />
                <DatePicker onChange={handleChangeDate} value={date} />
            </Stack>

            <Tooltip title="Filter list">
                <IconButton onClick={onOpenFilter}>
                    <Iconify icon="ic:round-filter-list" />
                </IconButton>
            </Tooltip>

        </Toolbar >
    );
}

TableToolbar.propTypes = {
    filterName: PropTypes.string,
    onFilterName: PropTypes.func,
    onOpenFilter: PropTypes.func,
    date: PropTypes.object,
    onChaneDate: PropTypes.func
};
