/**
 * 
 */
package com.yongchang.b2b.persistence.dao;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yongchang.b2b.persistence.entity.Role;

/**
 * @author zxc
 */
public interface RoleDao extends PagingAndSortingRepository<Role, Long>, JpaSpecificationExecutor<Role> {

    Role findByName(String name);
}
